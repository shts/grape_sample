module API
  module Ver1
    class Comments < Grape::API
      resource :comments do

        # GET /api/v1/comments
        desc 'Return all comments.'
        get do
          Comment.all
        end

        # GET /api/v1/comments/{:id}
        desc 'Return a comment.'
        params do
          requires :id, type: Integer, desc: 'Comment id.'
        end
        get ':id' do
          Comment.find(params[:id])
        end
      end
    end
  end
end
