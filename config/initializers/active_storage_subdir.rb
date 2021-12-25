Rails.configuration.to_prepare do
  ActiveStorage::Blob.class_eval do
    before_create :generate_key_with_prefix

    def generate_key_with_prefix
      self.key = if prefix
        File.join prefix, self.class.generate_unique_secure_token
      else
        self.class.generate_unique_secure_token
      end
    end

    def prefix
      spaces_version = "2"
      return "#{ENV["RAILS_ENV"]}_#{spaces_version}"
    end
  end
end