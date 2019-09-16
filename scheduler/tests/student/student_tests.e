note
	description: "Tests created by student"
	author: "You"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature -- Add tests

	make
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
		end

feature -- Tests

	t1: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t1: creating a heap from an array and testing heap property")
			-- Add your own test on heap and scheduler.
			create h.make (<<1, 2, 3, 4, 5>>, 7)
			Result := h.array ~ <<5, 4, 3, 1, 2, 0, 0>>
		end

	t2: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t2: Finding maximum from the arrayed heap")
			-- Add your own test on heap and scheduler.
			create h.make (<<1, 2, 3, 4, 5>>, 7)
			Result := h.maximum = 5
		end

	t3: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t3: Testing maximum capacity and actual number of keys in arrayed heap")
			-- Add your own test on heap and scheduler.
			create h.make (<<1, 2, 3, 4, 5>>, 7)
			Result := h.count = 5 and h.max_capacity = 7
		end

	t4: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t4: Testing the deletion of a max element in arrayed heap")
			-- Add your own test on heap and scheduler.
			create h.make (<<1, 2, 3, 4, 5>>, 7)
			h.remove_maximum
			Result := h.array ~ <<4, 2, 3, 1, 0, 0, 0>> and h.count = 4
		end

	t5: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t5: Testing the insertion of a new element in arrayed heap")
			-- Add your own test on heap and scheduler.
			create h.make (<<1, 2, 4>>, 5)
			Result := h.array ~ <<4, 2, 1, 0, 0>>
			check Result end
			h.insert (3)
			Result := h.array ~ <<4, 3, 1, 2, 0>> and h.count = 4
		end

	t6: BOOLEAN
		local
			s: SCHEDULER[STRING]
		do
			comment ("t6: Testing number of tasks, and maximum capacity of tasks in scheduler")
			-- Add your own test on heap and scheduler.
			create s.make_from_array (
				<<	["Physics Assignment", 4], ["Math Assignment", 1],
					["Biology Assignment",   3], ["Chemistry Assignment", 2],
					["CS Assignment", 5] >>, 7)
			Result := s.count = 5 and s.pq.count = 5 and s.pq.max_capacity = 7 and not s.is_empty
		end

	t7: BOOLEAN
		local
			s: SCHEDULER[STRING]
		do
			comment ("t7: Testing existence of priorities in scheduler")
			-- Add your own test on heap and scheduler.
			create s.make_from_array (
				<<	["Physics Assignment", 4], ["Math Assignment", 1],
					["Biology Assignment",   3], ["Chemistry Assignment", 2],
					["CS Assignment", 5] >>, 7)
			Result := s.priority_exists (3) and not s.priority_exists (6)
		end

	t8: BOOLEAN
		local
			s: SCHEDULER[STRING]
		do
			comment ("t8: Finding the highest priority task in scheduler")
			-- Add your own test on heap and scheduler.
			create s.make_from_array (
				<<	["Physics Assignment", 4], ["Math Assignment", 1],
					["Biology Assignment",   3], ["Chemistry Assignment", 2],
					["CS Assignment", 5] >>, 7)
			Result := s.next_task_to_execute ~ "CS Assignment"
		end

	t9: BOOLEAN
		local
			s: SCHEDULER[STRING]
		do
			comment ("t9: Testing post execution of a scheduled high priority task")
			-- Add your own test on heap and scheduler.
			create s.make_from_array (
				<<	["Physics Assignment", 4], ["Math Assignment", 1],
					["Biology Assignment",   3], ["Chemistry Assignment", 2],
					["CS Assignment", 5] >>, 7)
			s.execute_next_task
			Result := s.next_task_to_execute ~ "Physics Assignment" and not s.priority_exists (5) and s.count = 4
		end

	t10: BOOLEAN
		local
			s: SCHEDULER[STRING]
		do
			comment ("t10: Testing addition of a new task in scheduler")
			-- Add your own test on heap and scheduler.
			create s.make_from_array (
				<<	["Alan's Request"		,   4], ["Mark's Request"         ,   1],
						["Tom's Request"		,   3], ["SuYeon's Request"     ,   2],
						["Yuna's Request"		, 16], ["JaeBin's Request"       ,   9],
						["JiYoon's Request"	, 10], ["SeungYeon's Request", 14],
						["SunHye's Request"	,   8], ["JiHye's Request"         , 7 ]	>>
				, 15)
			s.add_task (["Adam's Request", 15])
			s.execute_next_task
			Result := s.next_task_to_execute ~ "Adam's Request"
		end
end
