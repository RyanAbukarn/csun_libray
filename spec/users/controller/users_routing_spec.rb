require 'rails_helper'

describe 'Users routing',type: :routing do
    it do 
        expect(get: "/all_users").to route_to(controller: "users", action: "all_users")
    end
    it do 
        expect(get: "/dashborad").to route_to(controller: "users", action: "dashboard")
    end
    it do 
        expect(get: "users/1/edit").to route_to(controller: "users", action: "edit", id: "1")
    end
    it do 
        expect(post: "/session").to route_to(controller: "sessions", action: "create")
    end
    it do 
        expect(get: "/signup").to route_to(controller: "users", action: "new")
    end
    it do 
        expect(delete: "/users/1").to route_to(controller: "users", action: "destroy",id: "1")
    end
    it do 
        expect(get: "/users/1").to route_to(controller: "users", action: "show",id: "1")
    end
   
end