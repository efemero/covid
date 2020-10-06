class TestsController < ApplicationController
  def index
    if params['update'] =="1"
      Test.delete_all
    end
    @tests = Test.all
    if @tests.length == 0
      resp = Faraday.get 'https://epistat.sciensano.be/Data/COVID19BE_tests.json'
      json_resp = JSON.parse resp.body
      all_tests = []
      for t in json_resp
        test = Hash.new
        test['date'] = t['DATE']
        test['province'] = t['PROVINCE']
        test['region'] = t['REGION']
        test['test_total'] = t['TESTS_ALL']
        test['test_pos'] = t['TESTS_ALL_POS']
        test['created_at'] = Time.now
        test['updated_at'] = Time.now
        all_tests.append(test)
      end
      Test.insert_all(all_tests)
      @tests = Test.all
    end

    @tests_by_date = Hash.new
    @tests_by_province = Hash.new
    @tests_by_region = Hash.new
    for test in @tests
      @tests_by_date[test.date] = []
      @tests_by_province[test.province] = []
      @tests_by_region[test.region] = []
    end
    for test in @tests
      @tests_by_date[test.date].append test
      @tests_by_province[test.province].append test
      @tests_by_region[test.region].append test
    end
    @positive_by_date = Hash.new
    @tests_by_date.each do |date, tests|
      total = 0
      pos = 0
      for test in tests
        total += test.test_total
        pos += test.test_pos
      end
      @positive_by_date[date] = {"total": total, "pos": pos}
    end

      

  end

  def update
    
  end
end
