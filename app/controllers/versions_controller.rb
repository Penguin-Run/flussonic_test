class VersionsController < ApplicationController
  def index
    


    data = { testMessage: 'test message' }
    respond_to do |format|
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end
end
