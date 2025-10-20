class Api::V1::StudentsController < ApplicationController

  # create_student
  def create_student
    begin
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold student_params
  private
  def student_params
    params.require(:student).permit(:user_id, :first_name, :last_name, :country)
  end
end
