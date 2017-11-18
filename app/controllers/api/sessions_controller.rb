class Api::SessionsController < Api::BaseController
  # TODO(caseytaka): fix authentication
  skip_before_action :verify_authenticity_token

  def create
    puts "SESSION CREATE PARAMS"
    puts params
    puts "END PARAMS"
    session = Session.new(session_params)
    if session.save
      render json: {
        session_id: session.id
      }
    else
      render_error_response(:forbidden, session.errors.full_messages)
    end
  end

  def update
    session = Session.find(params[:id])
    if session.update(session_params)
      render json: session
    else
      error_response(session)
    end
  end

  def destroy
    session = Session.find(params[:id])
    if session.destroy
      render json: session
    else
      error_response(session)
    end
  end

  private

  def session_params
    params.require(:session).permit(
      :weekday,
      :start_time,
      :end_time,
      :number,
      :course_id,
    )
  end
end
