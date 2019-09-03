class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

 def authorize_request
   header = request.headers['Authorization']
   header = header.split(' ').last if header
   begin
     @decoded = JsonWebToken.decode(header)
     @current_user = User.find(@decoded[:user_id])
   rescue ActiveRecord::RecordNotFound => e
     render json: { errors: e.message }, status: :unauthorized
   rescue JWT::DecodeError => e
     render json: { errors: e.message }, status: :unauthorized
   end
 end

 def set_user
   header = request.headers['Authorization']
   header = header.split(' ').last if header
   begin
     @decoded = JsonWebToken.decode(header)
     @current_user = User.find(@decoded[:user_id])
   rescue
     @current_user = nil
   end
 end

 def ensure_user_owns_record(record)
   render json: { errors: "Not Authorized" }, status: :unauthorized unless @current_user.id == record.user_id
 end
end
