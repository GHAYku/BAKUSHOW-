#!/bin/sh

arr=(
"app/admin/"
"app/assets/javascripts/active_admin.js"
"app/assets/stylesheets/active_admin.scss"
"app/models/admin_user.rb"
"config/initializers/active_admin.rb"
"db/migrate/20210912093525_devise_create_admin_users.rb"
"db/migrate/20210912093535_create_active_admin_comments.rb"
"test/fixtures/admin_users.yml"
"test/models/admin_user_test.rb"
"vendor/bundle/ruby/2.6.0/cache/activeadmin-2.9.0.gem"
"vendor/bundle/ruby/2.6.0/cache/arbre-1.4.0.gem"
"vendor/bundle/ruby/2.6.0/cache/formtastic-4.0.0.gem"
"vendor/bundle/ruby/2.6.0/cache/formtastic_i18n-0.7.0.gem"
"vendor/bundle/ruby/2.6.0/cache/has_scope-0.8.0.gem"
"vendor/bundle/ruby/2.6.0/cache/inherited_resources-1.13.0.gem"
"vendor/bundle/ruby/2.6.0/cache/ransack-2.4.2.gem"
"vendor/bundle/ruby/2.6.0/gems/activeadmin-2.9.0/"
"vendor/bundle/ruby/2.6.0/gems/arbre-1.4.0/"
"vendor/bundle/ruby/2.6.0/gems/formtastic-4.0.0/"
"vendor/bundle/ruby/2.6.0/gems/formtastic_i18n-0.7.0/"
"vendor/bundle/ruby/2.6.0/gems/has_scope-0.8.0/"
"vendor/bundle/ruby/2.6.0/gems/inherited_resources-1.13.0/"
"vendor/bundle/ruby/2.6.0/gems/ransack-2.4.2/"
"vendor/bundle/ruby/2.6.0/specifications/activeadmin-2.9.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/arbre-1.4.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/formtastic-4.0.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/formtastic_i18n-0.7.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/has_scope-0.8.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/inherited_resources-1.13.0.gemspec"
"vendor/bundle/ruby/2.6.0/specifications/ransack-2.4.2.gemspec"
 )

for file in "${arr[@]}"; 
do
	echo $file
	sudo rm -rf $file
done
