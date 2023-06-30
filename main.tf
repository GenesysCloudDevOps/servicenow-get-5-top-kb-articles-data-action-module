resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties": true,
        "properties": {
            "Domain": {
                "description": "The Service Now instance domain e.g. https://*domain*.service-now.com",
                "type": "string"
            }
        },
        "type": "object"
    })
    contract_output = jsonencode({
        "additionalProperties": true,
        "properties": {
            "result": {
                "items": {
                    "additionalProperties": true,
                    "properties": {
                        "short_description": {
                            "type": "string"
                        },
                        "text": {
                            "type": "string"
                        }
                    },
                    "title": "Item 1",
                    "type": "object"
                },
                "type": "array"
            }
        },
        "type": "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "https://$${input.Domain}.service-now.com/api/now/table/kb_knowledge?sysparm_limit=5"
        
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}