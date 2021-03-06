/*作业请提交在这个目录下*/
pragma solidity ^0.4.14;

contract Payroll {
    uint constant payDuration = 10 seconds;
    address owner;
    uint salary;
    address employee;
    uint lastPayday;

    function Payroll() {
        owner = msg.sender;
    }
    
    function updateEmployee(address e, uint s) {
        require(msg.sender == owner);
        if (employee != 0x0) {
            uint payment = salary * (now - lastPayday) / payDuration;
            employee.transfer(payment);
        }
        employee = e;
        salary = s * 1 ether;
        lastPayday = now;
    }
    
    function updateEmployeeAddress(address e) {
        require(msg.sender == owner);
        employee = e;
    }
    
    function updateEmployeeSalary(uint s) {
        require(msg.sender == owner);
        if (employee != 0x0) {
            uint payment = salary * (now - lastPayday) / payDuration;
            employee.transfer(payment);
        }
        salary = s * 1 ether;
        lastPayday = now;
    }
    
    function addFund() payable returns (uint) {
        return this.balance;
    }
    
    function calculateRunway() returns (uint) {
        return this.balance / salary;
    }
    
    function hasEnoughFund() returns (bool) {
        return calculateRunway() > 0;
    }
    
    function getPaid() {
        require(msg.sender == employee);
        uint nextPayday = lastPayday + payDuration;
        require(nextPayday < now);
        lastPayday = nextPayday;
        employee.transfer(salary);
    }
}
