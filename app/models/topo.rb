class Topo < ApplicationRecord
  has_many :lines, dependent: :destroy
  has_many :problems, through: :lines

  audited

  scope :published, -> { where(published: true) }

  validates :photo, presence: true

  after_commit -> do
    photo.attachment.blob.open do |file|
      gps_data = EXIFR::JPEG.new(file).gps
      prefill_problems_with_gps_data gps_data if gps_data.present?
    end
  end

  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_fill: [1200, 900], saver: { quality: 50, strip: true, interlace: true }, preprocessed: true
  end

  def metadata_latitude
    metadata["latitude"] 
  end

  def metadata_longitude
    metadata["longitude"] 
  end

  def metadata_horizontal_accuracy
    metadata["horizontalAccuracy"] 
  end

  def metadata_heading
    metadata["heading"] 
  end

  private

  def prefill_problems_with_gps_data(gps_data)
    problems.without_location.each do |problem|
      problem.location = FACTORY.point(gps_data.longitude, gps_data.latitude)
      problem.save!
    end
  end
end
