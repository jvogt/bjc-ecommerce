#
# Cookbook Name:: bjc-ecommerce
# Recipe:: tomcat
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'tomcat7' do
  action :install
end

directory '/usr/share/tomcat7/logs' do
  action :create
end
