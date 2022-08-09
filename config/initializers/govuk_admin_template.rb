# We were setting app_title here, but we needed to use the department.name from
# localisations, which aren't available in initializers. Our solution was to move
# it to app/views/application.html.erb.
GovukAdminTemplate.environment_style = Rails.env.staging? ? 'preview' : ENV['RAILS_ENV']
GovukAdminTemplate.environment_label = Rails.env.titleize
