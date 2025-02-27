
class Employee {

    String name, designation, department, reportingTo;
    int age;

    Employee(String name, int age, String designation, String department, String reportingTo) {
        this.name = name;
        this.age = age;
        this.designation = designation;
        this.department = department;
        this.reportingTo = reportingTo;
    }

    public String toString() {
        return String.format("%-10s %-5d %-15s %-15s %-10s", name, age, designation, department, reportingTo);
    }
}
