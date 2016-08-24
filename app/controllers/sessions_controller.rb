class SessionsController < ApplicationController

  def destroy
    session_destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
