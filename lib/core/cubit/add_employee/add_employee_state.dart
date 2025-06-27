part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

final class AddEmployeeInitial extends AddEmployeeState {}
final class AddEmployeeLoading extends AddEmployeeState {}
final class AddEmployeeSuccess extends AddEmployeeState {}
final class AddEmployeeFailed extends AddEmployeeState {
  final String errMessage;
  const AddEmployeeFailed({required this.errMessage});
}
