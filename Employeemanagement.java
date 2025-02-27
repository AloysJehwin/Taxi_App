import java.util.*;
import java.util.stream.Collectors;

public class Employeemanagement {
    static List<Employee> employees = new ArrayList<>();

    public static void main(String[] args) {
        employees.add(new Employee("John", 30, "Manager", "HR", "Alice"));
        employees.add(new Employee("Jane", 25, "Developer", "IT", "John"));
        employees.add(new Employee("Doe", 35, "Tester", "IT", "John"));
        employees.add(new Employee("Alice", 40, "Director", "HR", ""));

        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println(
                    "1. Display Employees\n2. Search Employees\n3. Reporting Tree\n4. Employees under Manager\n5. Summary\n6. Exit");
            int choice = sc.nextInt();
            sc.nextLine();
            switch (choice) {
                case 1:
                    displayEmployees();
                    break;
                case 2:
                    searchEmployees(sc);
                    break;
                case 3:
                    printReportingTree(sc);
                    break;
                case 4:
                    printEmployeesUnderManager(sc);
                    break;
                case 5:
                    printSummary();
                    break;
                case 6:
                    return;
                default:
                    System.out.println("Invalid choice.");
            }
        }
    }

    static void displayEmployees() {
        System.out.println("Name       Age   Designation     Department      ReportingTo");
        for (Employee e : employees)
            System.out.println(e);
    }

    static void searchEmployees(Scanner sc) {
        System.out.println("Enter field (name/age/designation/department/reportingTo):");
        String field = sc.nextLine();
        System.out.println("Enter value:");
        String value = sc.nextLine();

        List<Employee> result = employees.stream()
                .filter(e -> {
                    switch (field) {
                        case "name":
                            return e.name.contains(value);
                        case "age":
                            return e.age == Integer.parseInt(value);
                        case "designation":
                            return e.designation.contains(value);
                        case "department":
                            return e.department.contains(value);
                        case "reportingTo":
                            return e.reportingTo.contains(value);
                    }
                    return false;
                })
                .collect(Collectors.toList());

        if (result.isEmpty())
            System.out.println("No records found.");
        else
            result.forEach(System.out::println);
    }

    static void printReportingTree(Scanner sc) {
        System.out.println("Enter Employee Name:");
        String name = sc.nextLine();
        while (!name.isEmpty()) {
            System.out.println(name);
            String currentName = name;
            name = employees.stream().filter(e -> e.name.equals(currentName)).map(e -> e.reportingTo).findFirst()
                    .orElse("");
        }
    }

    static void printEmployeesUnderManager(Scanner sc) {
        System.out.println("Enter Manager Name:");
        String manager = sc.nextLine();
        employees.stream()
                .filter(e -> e.reportingTo.equals(manager))
                .forEach(System.out::println);
    }

    static void printSummary() {
        System.out.println("Department Summary:");
        employees.stream().collect(Collectors.groupingBy(e -> e.department, Collectors.counting()))
                .forEach((dept, count) -> System.out.println(dept + ": " + count));
    }
}