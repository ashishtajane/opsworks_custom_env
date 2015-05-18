# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of custom environment settings)
# 
# Notifies the restart resource defined in opsworks-cookbooks/rails/providers/configuration.rb

define :custom_env_template do
  
  template "#{params[:deploy][:deploy_to]}/shared/config/application.yml" do
    source "application.yml.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env]
    notifies :run, resources(:execute => "Restart Rails App #{params[:application]}")

    only_if do
      File.exists?("#{params[:deploy][:deploy_to]}/shared/config")
    end
  end
  
end
