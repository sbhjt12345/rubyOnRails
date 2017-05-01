User.destroy_all
TodoList.destroy_all
TodoItem.destroy_all
Profile.destroy_all

# Create users
user001 = User.create!(username: "Fiorina", password_digest: "pass001")
user002 = User.create!(username: "Trump", password_digest: "pass002")
user003 = User.create!(username: "Carson", password_digest: "pass003")
user004 = User.create!(username: "Clinton", password_digest: "pass004")


# Create profile for users
profile1 = Profile.create!(gender: "female",
                          birth_year: 1954,
                          first_name: "Carly",
                          last_name: "Fiorina")
profile2 = Profile.create!(gender: "male",
                          birth_year: 1946,
                          first_name: "Donald",
                          last_name: "Trump")
profile3 = Profile.create!(gender: "male",
                          birth_year: 1951,
                          first_name: "Ben",
                          last_name: "Carson")
profile4 = Profile.create!(gender: "female",
                          birth_year: 1947,
                          first_name: "Hillary",
                          last_name: "Clinton")

# Create TodoLists
todoList001 = TodoList.create!( list_name: "List 'Carly'",
                                list_due_date: Date.today + 1.year)
todoList002 = TodoList.create!( list_name: "List 'Donald'",
                                list_due_date: Date.today + 1.year)
todoList003 = TodoList.create!( list_name: "List 'Ben'",
                                list_due_date: Date.today + 1.year)
todoList004 = TodoList.create!( list_name: "List 'Hillary'",
                                list_due_date: Date.today + 1.year)




# Create 'TodoItems' For 'user001'
todoList001.todo_items.create! [
    {
      due_date: Date.today + 1.year,
      title: "Item 'Carly' #1",
      description: "Description Item 'Carly' #1",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Carly' #2",
      description: "Description Item 'Carly' #2",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Carly' #3",
      description: "Description Item 'Carly' #3",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Carly' #4",
      description: "Description Item 'Carly' #4",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Carly' #5",
      description: "Description Item 'Carly' #4",
      completed: false
    }

]

# Create 'todo_lists' For 'user002'
todoList002.todo_items.create! [
    {
      due_date: Date.today + 1.year,
      title: "Item 'Donald' #1",
      description: "Description Item 'Carly' #1",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Donald' #2",
      description: "Description Item 'Carly' #2",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Donald' #3",
      description: "Description Item 'Carly' #3",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Donald' #4",
      description: "Description Item 'Carly' #4",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Donald' #5",
      description: "Description Item 'Carly' #4",
      completed: false
    }

]

# Create 'todo_lists' For 'user003'
todoList003.todo_items.create! [
    {
      due_date: Date.today + 1.year,
      title: "Item 'Ben' #1",
      description: "Description Item 'Carly' #1",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Ben' #2",
      description: "Description Item 'Carly' #2",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Ben' #3",
      description: "Description Item 'Carly' #3",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Ben' #4",
      description: "Description Item 'Carly' #4",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Ben' #5",
      description: "Description Item 'Carly' #4",
      completed: false
    }

]

# Create 'todo_lists' For 'user004'
todoList004.todo_items.create! [
    {
      due_date: Date.today + 1.year,
      title: "Item 'Hillary' #1",
      description: "Description Item 'Carly' #1",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Hillary' #2",
      description: "Description Item 'Carly' #2",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Hillary' #3",
      description: "Description Item 'Carly' #3",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Hillary' #4",
      description: "Description Item 'Carly' #4",
      completed: false
    },

    {
      due_date: Date.today + 1.year,
      title: "Item 'Hillary' #5",
      description: "Description Item 'Carly' #4",
      completed: false
    }

]

user001.profile = profile1
user002.profile = profile2
user003.profile = profile3
user004.profile = profile4

user001.todo_lists << todoList001
user002.todo_lists << todoList002
user003.todo_lists << todoList003
user004.todo_lists << todoList004



