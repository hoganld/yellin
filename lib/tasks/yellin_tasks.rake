require 'fileutils'

namespace :yellin do
  namespace :install do
    desc "Install Yellin views"
    task :views do
      source_root = Gem.loaded_specs['yellin'].full_gem_path
      Dir.glob(File.join(source_root, "app/views/**/*.erb")).each do |view|
        view.slice!(source_root)
        path = view.split('/')
        filename = path.pop
        FileUtils.mkdir_p(File.join(Rails.root, path))
        source = File.join(source_root, path, filename)
        target = File.join(Rails.root, path, filename)
        copy_file source, target
      end
    end
  end

  namespace :uninstall do
    desc "Uninstall Yellin views"
    task :views do
      FileUtils.rm_rf(File.join(Rails.root, "app/views/yellin"))
      FileUtils.rm_rf(File.join(Rails.root, "app/views/layouts/yellin"))
    end
  end
end
