class Header
  def main_logo
    ''"
          ██████╗░░█████╗░██╗██╗░░░░░██████╗░░█████╗░░█████╗░██████╗░     ███╗░░░███╗░█████╗░███╗░░██╗░█████╗░░██████╗░███████╗██████╗░
          ██╔══██╗██╔══██╗██║██║░░░░░██╔══██╗██╔══██╗██╔══██╗██╔══██╗     ████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝░██╔════╝██╔══██╗
          ██████╔╝███████║██║██║░░░░░██████╔╝██║░░██║███████║██║░░██║     ██╔████╔██║███████║██╔██╗██║███████║██║░░██╗░█████╗░░██████╔╝
          ██╔══██╗██╔══██║██║██║░░░░░██╔══██╗██║░░██║██╔══██║██║░░██║     ██║╚██╔╝██║██╔══██║██║╚████║██╔══██║██║░░╚██╗██╔══╝░░██╔══██╗
          ██║░░██║██║░░██║██║███████╗██║░░██║╚█████╔╝██║░░██║██████╔╝     ██║░╚═╝░██║██║░░██║██║░╚███║██║░░██║╚██████╔╝███████╗██║░░██║
          ╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═════╝░     ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═╝░░╚═╝
    "''
  end

  def main_menu
    ''"
    1. Создать станцию.
    2. Создать поезд.
    3. Создать/Изменить маршрут.
    4. Назначить маршрут поезду.
    5. Прицепить вагон.
    6. Отцепить вагон.
    7. Переместить поезд
    8. Список станций и поездов
    9. Выход из программы.
    "''
  end

  def train_type_menu
    ''"
    1. Пассажирский
    2. Грузовой
    "''
  end

  def route_menu
    ''"
    1. Создать новый маршрут
    2. Редактировать существующий
    9. Вернуться в главное меню
    "''
  end
end
