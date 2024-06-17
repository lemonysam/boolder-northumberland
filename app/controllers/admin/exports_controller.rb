class Admin::ExportsController < Admin::BaseController
  def new
    ExportAreasJob.perform_now
    ExportProblemsJob.perform_now

    flash[:notice] = "Mapbox data exported"
    redirect_to admin_areas_path
  end
end