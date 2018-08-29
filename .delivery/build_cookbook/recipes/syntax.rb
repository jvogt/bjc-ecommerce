#
# Cookbook Name:: build_cookbook
# Recipe:: syntax
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'delivery-truck::syntax'

include_recipe 'delivery-truck::publish'

# THERE CAN BE ONLY ONE
cookbook_name = changed_cookbooks.map(&:name).first

delivery_push_job "update-nodes" do
    command 'chef-client'
    nodes delivery_chef_server_search(:node, "recipes:#{cookbook_name}*").map(&:name)
end
