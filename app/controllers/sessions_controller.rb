class SessionsController < ApplicationController

  def destroy
    session[:id] = nil
    respond_to do |format|
      format.json { head :no_content }
    end
  end

end
