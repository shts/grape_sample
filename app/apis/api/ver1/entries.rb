module API
  module Ver1
    class Entries < Grape::API
      resource :entries do

        # GET /api/v1/entries
        # GET /api/v1/entries?skip={:skip}&limit={:limit}
        desc 'Return all entries.'
        params do
          optional :skip, type: Integer, desc: 'Skip range.'
          optional :limit, type: Integer, desc: 'Limit of entries.'
        end
        get '', jbuilder:'entries/index' do
          if params[:skip].present? && params[:limit].present? then
            @entries = Entry.where("id > ?", params[:skip])
                            .limit(params[:limit])
                            .order(publicshed: :desc)
          elsif params[:skip].present? then
            @entries = Entry.where("id > ?", params[:skip])
                            .order(publicshed: :desc)
          elsif params[:limit].present? then
            @entries = Entry.limit(params[:limit])
                            .order(publicshed: :desc)
          else
            @entries = Entry.limit(30).order(publicshed: :desc)
          end
        end

        # GET /api/v1/entries/{:id}
        desc 'Return a entry.'
        params do
          requires :id, type: Integer, desc: 'Entry id.'
        end
        get ':id' do
          # ActiveRecord::RecordNotFound が発生する可能性がある
          Entry.find(params[:id])
        end
        
        # GET /api/v1/entries/members/{:member_id}?skip={:skip}&limit={:limit}
        desc 'Return a member entries.'
        params do
          requires :member_id, type: Integer, desc: 'Member id.'
          optional :skip, type: Integer, desc: 'Skip range.'
          optional :limit, type: Integer, desc: 'Limit of entries.'
        end
        get 'members/:member_id', jbuilder:'entries/index' do
          if params[:skip].present? && params[:limit].present? then
            @entries = Entry.where("member_id > ?", params[:member_id])
                            .where("id > ?", params[:skip])
                            .limit(params[:limit])
                            .order(publicshed: :desc)
          elsif params[:skip].present? then
            @entries = Entry.where("member_id > ?", params[:member_id])
                            .where("id > ?", params[:skip])
                            .order(publicshed: :desc)
          elsif params[:limit].present? then
            @entries = Entry.where("member_id > ?", params[:member_id])
                            .limit(params[:limit])
                            .order(publicshed: :desc)
          else
            @entries = Entry.limit(30).order(publicshed: :desc)
          end
        end
        
      end
    end
  end
end
