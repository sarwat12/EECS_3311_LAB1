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
--			add_boolean_case (agent t2)
--			add_boolean_case (agent t3)
--			add_boolean_case (agent t4)
--			add_boolean_case (agent t5)
--			add_boolean_case (agent t6)
--			add_boolean_case (agent t7)
--			add_boolean_case (agent t8)
--			add_boolean_case (agent t9)
--			add_boolean_case (agent t10)
		end

feature -- Tests

	t1: BOOLEAN
		local
			h: ARRAYED_HEAP
		do
			comment ("t1: creating a heap")
			-- Add your own test on heap and scheduler.
			create h.make (<<4, 1, 3, 2, 16, 9, 10, 14, 8, 7>>, 15)
			print(h.array)
			Result := h.array ~ <<16, 14, 10, 8, 7, 9, 3, 2, 4, 1, 0, 0, 0, 0, 0>>
		end

--	t2: BOOLEAN
--		do
--			comment ("t2: comment of t2")
--			-- Add your own test on heap and scheduler.
--		end

--	t3: BOOLEAN
--		do
--			comment ("t3: comment of t3")
--			-- Add your own test on heap and scheduler.
--		end

--	t4: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t5: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t6: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t7: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t8: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t9: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end

--	t10: BOOLEAN
--		do
--			comment ("t1: comment of t1")
--			-- Add your own test on heap and scheduler.
--		end
end
