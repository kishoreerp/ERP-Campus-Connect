String courseToShort(String course) {
  final map = {
    'Information Technology': 'IT',
    'Computer Science Engineering': 'CSE',
    'Computer Science & Engineering': 'CSE',
    'CSE (Cyber Security)': 'CS',
    'AI & Data Science': 'AI',
    'Electronics And Communication': 'EC',
    'Electronics & Communication': 'EC',
    'MBA': 'MBA',
    'ME CSE': 'ME',
    'Mechanical Engineering': 'ME',
    'Civil Engineering': 'CE',
    'Admission Admin': 'AA',
  };

  return map[course] ?? course;
}