require 'net/http'
require 'uri'
module Api::V1::UserHelper
  TOKEN = ''

  def transaction_result?(amount:, destination:)


    url = 'http://api.goldbank.ru/transfer'
    query =  {
                 amount: amount,
                 currency: 'USD',
                 destination: destination,
                 token: TOKEN
               }

    RestClient.post(url, query){|response, request, result| response
     case response.code
     when 200
       true
     else
       false
     end}

    end

end
