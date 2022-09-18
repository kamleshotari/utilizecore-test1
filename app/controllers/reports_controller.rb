class ReportsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @reports = Report.with_attached_file
  end

  def download
    @report = Report.find(params[:id])
    @blob = @report.file.blob
    send_data @blob.download, type: @blob.content_type, disposition: 'inline', filename: @blob.filename.to_s + ".xlsx"
  end
end
