namespace :bump_version do
  desc "create VERSION.  Use MAJOR_VERSION, MINOR_VERSION, BUILD_VERSION to override defaults"
  task bump_version: :environment do
    version_file = "#{Rails.root}/config/initializers/version.rb"
    major = ENV["MAJOR_VERSION"] || 1
    minor = ENV["MINOR_VERSION"] || 0
    build = ENV["BUILD_VERSION"] || `git describe --always --tags`
    version_string = "VERSION = #{[major.to_s, minor.to_s, build.strip]}\n"
    File.open(version_file, "w") {|f| f.print(version_string)}
    $stderr.print(version_string)
  end

end
