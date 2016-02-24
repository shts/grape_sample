module API
  module Ver1
    class Comments < Grape::API
      resource :comments do

        # GET /api/v1/comments
        # do not use
        desc 'Return all comments.'
        get do
          Comment.all
        end

        # GET /api/v1/comments/{:id}
        # do not use
        desc 'Return a comment.'
        params do
          requires :id, type: Integer, desc: 'Comment id.'
        end
        get ':id' do
          Comment.find(params[:id])
        end

        # GET /api/v1/comments/entry/{:entry_id}
        desc 'Return a comment.'
        params do
          requires :entry_id, type: Integer, desc: 'Entry id.'
        end
        get 'entry/:entry_id' do
          Comment.where("entry_id = ?", params[:entry_id])
        end

      end
    end
  end
end
