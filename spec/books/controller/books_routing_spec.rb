require 'rails_helper'

describe 'Books routing',type: :routing do
    it do 
        expect(get: "/").to route_to(controller: "books", action: "index")
    end
    it do 
        expect(get: "books/new").to route_to(controller: "books", action: "new")
    end
    it do 
        expect(get: "books/1/edit").to route_to(controller: "books", action: "edit", id: "1")
    end
    it do 
        expect(post: "/books").to route_to(controller: "books", action: "create")
    end
    it do 
        expect(delete: "/books/1").to route_to(controller: "books", action: "destroy",id: "1")
    end
    it do 
        expect(get: "/books/1").to route_to(controller: "books", action: "show",id: "1")
    end
    it do 
        expect(get: "/all_books").to route_to(controller: "books", action: "all_books")
    end
    it do 
        expect(get: "/by_date").to route_to(controller: "books", action: "by_date")
    end
end