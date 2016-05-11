module PaperTrail
  class Version < ActiveRecord::Base
    PaperTrail.config.track_associations = false
    include PaperTrail::VersionConcern
  end
end