#
# Cookbook Name:: bjc-ecommerce
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

%w(mysql-server mysql-client).each do |p|
  package p do
    action :install
  end
end

execute 'Add ecommerce database' do
  command "echo 'create database softslate' | mysql -u root"
  action :run
  not_if "echo 'show databases' | mysql -u root | grep softslate"
end
