class GetYearBudget {
  int curmonth = DateTime.now().month;
  int curyear = DateTime.now().year + 543;

  int getYearBudget() {
    if (curmonth >= 1 && curmonth <= 9) // january-september
    {
      return curyear;
    } else // oct-nov-dec
    {
      return curyear + 1;
    }
  }
}
