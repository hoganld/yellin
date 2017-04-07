class YellinGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_initializer_file
    template "initializer.rb", "config/initializers/yellin.rb"
  end

  def mount_engine
    route "mount Yellin::Engine => '/'"
  end

  hook_for :orm
end
