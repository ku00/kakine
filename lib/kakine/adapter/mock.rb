module Kakine
  class Adapter
    class Mock
      include Kakine::Adapter::Base
      def create_rule(security_group_id, direction, security_rule)
        attributes = {}
        %w(protocol port_range_max port_range_min remote_ip ethertype).each do |k|
          attributes[k] = eval("security_rule.#{k}")
        end
        if attributes["remote_ip"]
          attributes["remote_ip_prefix"] = attributes.delete("remote_ip")
        end

        puts "Create Rule: #{security_group_id} - #{security_rule.direction}: #{attributes}"
        "Create Rule: #{security_group_id}"
      end

      def delete_rule(security_group_rule_id)
        puts "Delete Rule: #{security_group_rule_id}"
        "Delete Rule: #{security_group_rule_id}"
      end

      def create_security_group(attributes)
        data = {}
        attributes.each{|k,v| data[k.to_sym] = v}
        puts "Create Security Group: #{data}"
        "Create Security Group: #{attributes[:name]}"
      end

      def delete_security_group(security_group_id)
        puts "Delete Security Group: #{security_group_id}"
        "Delete Security Group: #{security_group_id}"
      end

      def security_group(tenant_name, sg_name)
        self
      end

      def id(sg_name)
        "#{sg_name}"
      end
    end
  end
end
