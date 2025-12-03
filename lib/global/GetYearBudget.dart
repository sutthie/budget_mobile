class GetYearBudget {
  static int getYearBudget() {
    int curmonth = DateTime.now().month;
    int curyear = DateTime.now().year + 543;

    if (curmonth >= 1 && curmonth <= 9) // january-september
    {
      return curyear;
    } else // oct-nov-dec
    {
      return curyear + 1;
    }
  }
}
