module API
  module Ver1
    class Root < Grape::API
      # http://localhost:3000/api/v1/
      version 'v1'
      format :json 
      formatter :json, Grape::Formatter::Jbuilder
      #error_formatter :json, Formatter::Error
      
      mount API::Ver1::Members
      mount API::Ver1::Entries
      mount API::Ver1::Comments
    end
  end
end
