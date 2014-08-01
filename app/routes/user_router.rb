#
# User controller
#
class BobaAPI < Sinatra::Base

  namespace '/protected' do

    # index
    get "/users" do
      content_type :json

      if users = User.all
        users.to_a.to_json
      else
        halt 404
      end
    end

    # self
    get "/user/profile" do
      content_type :json

      user = @token.user rescue nil
      if user
        user.to_json
      else
        {
          error: "user not found",
          messages: "user not found"
        }.to_json
      end
    end

    # find
    get "/user/:id" do
      content_type :json

      user = User.find_by(user_id: params[:id].to_i) rescue nil
      if user
        user.to_json
      else
        {
          error: "user not found",
          messages: "user not found"
        }.to_json
      end
    end

    # # delete
    # delete '/user/:id' do
    #   content_type :json

    #   user = User.find_by(user_id: params[:id].to_i) rescue nil

    #   if user && user.destroy!
    #     {success: "user deleted"}.to_json
    #   else
    #     {
    #       error: "deleting error",
    #       messages: "deleting error"
    #     }.to_json
    #   end
    # end
  end
end