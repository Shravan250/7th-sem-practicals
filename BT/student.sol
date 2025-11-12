// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegister {
    // 1. STRUCTURE - Student data structure
    struct Student {
        uint studentId;
        string name;
        uint[] marks;      // 2. ARRAY - marks array
        uint percentage;
    }
    
    // Array of students
    Student[] public students;
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    // Register a new student
    function register(uint _id, string memory _name, uint[] memory _marks) public {
        require(_marks.length == 3, "Need 3 subjects");
        
        uint total = 0;
        for (uint i = 0; i < _marks.length; i++) {
            total += _marks[i];
        }
        uint percentage = (total * 100) / 300;
        
        students.push(Student(_id, _name, _marks, percentage));
    }
    
    // Get student details
    function getStudent(uint index) public view returns (uint, string memory, uint[] memory, uint) {
        Student memory s = students[index];
        return (s.studentId, s.name, s.marks, s.percentage);
    }
    
    // Get total students count
    function getTotalStudents() public view returns (uint) {
        return students.length;
    }
    
    // 3. FALLBACK - called when function doesn't exist or with data
    fallback() external payable {
        // Fallback executed
    }
    
    // RECEIVE - called when plain Ether sent
    receive() external payable {
        // Ether received
    }
    
    // Check contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}