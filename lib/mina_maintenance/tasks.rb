# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### maintenance_template
# Sets a file with maintenance page template.
set_default :maintenance_template, File.join(File.expand_path('../templates', __FILE__), 'maintenance.html')

# ### maintenance_basename
# Sets the basename of server's file used to display maintenance message.
# Default: maintenance
set_default :maintenance_basename, 'maintenance'

# ### maintenance_path
# Sets a path to the server's mainenance file on server.
# Default: /public/system/
set_default :maintenance_path, '/public/system/'

# ## Control Tasks
namespace :maintenance do
  desc "Turn on maintenance mode"
  task :on do
    queue %[echo "-----> Turning maintenance mode ON"]

    template = settings.maintenance_template
    result   = File.open(template).read

    rendered_path = "#{deploy_to}/#{shared_path}/#{settings.maintenance_path}"
    rendered_name = "#{settings.maintenance_basename}.html"

    queue %[
      if [ ! -e '#{rendered_path}' ]; then
        echo "-----> Creating missing directories"
        mkdir -pv #{rendered_path}
      fi
    ]

    queue! %[echo "#{result}" > #{rendered_path + rendered_name};]
    queue! %[chmod 644 #{rendered_path + rendered_name}]
  end

  desc "Turn off maintenance mode"
  task :off do
    queue %[echo "-----> Turning maintenance mode OFF"]

    queue! %[rm -f #{deploy_to}/#{shared_path}/public/system/#{settings.maintenance_basename}.html]
  end
end