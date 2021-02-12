.data
	arr: .skip 40
	enter_a_number: .asciz "Enter a number:"
	input_format: .asciz "%d"
	output: .asciz "%d\n"
	enter_search: .asciz "Enter a number to search:"
	number_found: .asciz "Number is found at the index %d\n"
	not_found: .asciz "Not found\n"
	input: .word 0
	search_number: .word 0
	i: .word 0

.text

.global main
addr_arr: .word arr
addr_enter_a_number: .word enter_a_number
addr_input_format: .word input_format
addr_output: .word output
addr_enter_search: .word enter_search
addr_number_found: .word number_found
addr_not_found: .word not_found
addr_input: .word input
addr_search_number: .word search_number
addr_i: .word i

main:
	str lr, [sp, #-4]!
	
loop:
	// Ask for numbers
	ldr r0, addr_enter_a_number
	bl printf
	
	ldr r0, addr_input_format
	ldr r1, addr_input
	bl scanf
	
	// Store number
	ldr r3, addr_i
	ldr r2, [r3]
	mov r4, #4
	mul r1, r2, r4 // Get offset
	ldr r4, addr_arr
	add r4, r4, r1
	ldr r1, addr_input
	ldr r1, [r1]
	str r1, [r4]
	
	// Check loop condition
	add r2, r2, #1
	str r2, [r3]
	cmp r2, #10
	blt loop

/*	
	// Print array
	mov r0, #0
	ldr r1, addr_i
	str r0, [r1]
print_loop:
	ldr r3, addr_i
	ldr r2, [r3]
	mov r4, #4
	mul r1, r2, r4
	ldr r4, addr_arr
	add r4, r4, r1
	ldr r1, [r4]
	ldr r0, addr_output
	bl printf
	ldr r3, addr_i
	ldr r2, [r3]
	add r2, r2, #1
	str r2, [r3]
	cmp r2, #10
	blt print_loop
*/

	// Ask for search number
	ldr r0, addr_enter_search
	bl printf
	
	ldr r0, addr_input_format
	ldr r1, addr_search_number
	bl scanf
	
	ldr r0, addr_search_number
	ldr r0, [r0]
	
	mov r1, #0 // i
	
	// Search for number
search_loop:
	// Get item
	mov r2, #4
	mul r3, r1, r2
	ldr r4, addr_arr
	add r4, r4, r3
	ldr r2, [r4]
	
	cmp r0, r2
	beq found
	
	// Check loop condition
	add r1, r1, #1
	cmp r1, #10
	blt search_loop

	ldr r0, addr_not_found
	bl printf
	b exit
	
found:
	ldr r0, addr_number_found
	// r1 is i
	bl printf
	b exit

exit:
	ldr lr, [sp]
	mov r0, #0
	bx lr
