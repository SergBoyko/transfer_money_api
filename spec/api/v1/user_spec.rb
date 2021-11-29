require 'rails_helper'
require 'webmock/rspec'
require 'net/http'

describe Api::V1::UsersController do
  include Api::V1::UserHelper
  before(:each) do
    stub_request(:post, "http://api.goldbank.ru/transfer").
      with(
        body: {"amount"=>"1", "currency"=>"USD", "destination"=>"2", "token"=>""},
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length'=>'42',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'Host'=>'api.goldbank.ru',
          'User-Agent'=>'rest-client/2.1.0 (linux x86_64) ruby/2.7.4p191'
        }).
      to_return(status: 200, body: "", headers: {})
    stub_request(:post, "http://api.goldbank.ru/transfer").
      with(
        body: {"amount"=>"1", "currency"=>"USD", "destination"=>"1", "token"=>""},
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length'=>'42',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'Host'=>'api.goldbank.ru',
          'User-Agent'=>'rest-client/2.1.0 (linux x86_64) ruby/2.7.4p191'
        }).
      to_return(status: 200, body: "", headers: {})



  end
  it 'should return 200 code for #index' do
    url = 'http://localhost:3000/api/v1/users/'
    response = RestClient.get(url)
    expect(response.code).to eq 200
  end

  it 'sould check that user have enough money' do
    url = 'http://localhost:3000/api/v1/users/1'
    query = {params: {amount: 100000, destination: 2}}
    response = RestClient.put(url,query){|response, request, result| response }
    expect(response.code).to eq 400
  end

  it 'should bank transaction return 200 true' do
    expect(transaction_result?(amount: 1, destination: 1)).to eq true
  end

  it 'should reduce user balance' do
    url = 'http://localhost:3000/api/v1/users/1'
    query = {params: {amount: 1, destination: 2}}
    RestClient.put(url,query){|response, request, result| response }
    user_balance = Api::V1::User.find(1)
    expect(user_balance.amount).to eq 96
  end

end