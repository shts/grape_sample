module API
  module Ver1
    class Members < Grape::API
      resource :members do

        # GET /api/v1/members
        desc 'Return all member.'
        get do
          Member.all
        end

        # GET /api/v1/members/{:id}
        desc 'Return a member.'
        params do
          requires :id, type: Integer, desc: 'Member id.'
        end
        get ':id' do
          Member.find(params[:id])
        end
      end
    end
  end
end
