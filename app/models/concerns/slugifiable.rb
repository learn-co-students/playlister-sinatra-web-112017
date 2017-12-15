module Slugifiable

  module InstanceMethods

    def slug
      self.name.downcase.gsub('-','_').gsub(' ','-') if self.name
    end
  end

  module ClassMethods

    def find_by_slug(slug)
      slug_name = slug.split("-").join(" ").gsub('_','-')
      self.all.where("lower(name) = ?", slug_name.downcase).first
    end
  end

end
