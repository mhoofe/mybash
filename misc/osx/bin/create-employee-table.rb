#!/usr/bin/env ruby

#
# To create a list of users for a specific group in YAML use:
#
# > az ad group member list --group "Rheinauhafen" --output yaml
#

require 'yaml'

def get hash, key
  value = hash[key]
  return nil if value.nil? or not value.is_a?(String) or value.empty?
  value.strip
end

def split value
  return nil if value.nil? or not value.is_a?(String) or value.empty?
  return value.split(',').map { |v| v.strip }
end

yaml = YAML.load(STDIN)

employees = []
yaml.each do |employee|

  employee = {
    name: get(employee, 'displayName'),
    givenName: get(employee, 'givenName'),
    surname: get(employee, 'surname'),
    title: get(employee, 'jobTitle'),
    email: get(employee, 'mail'),
    telefone: get(employee, 'telephoneNumber'),
    mobile: get(employee, 'mobile'),
    departments: split(get(employee, 'department'))
  }
  employees << employee

end

puts employees

