part of '../i_ticket_repository.dart';

@Singleton(as: ITicketRepository, env: [Environment.dev])
class TicketRepository implements ITicketRepository {
  final ILocalStorage _localStorage = singleton.get<ILocalStorage>();
  final List<TicketData> _tickets = [];

  final ValueNotifier<Iterable<TicketData>?> _ticketController =
      ValueNotifier(null);

  final ValueNotifier<Iterable<TicketData>?> _unLoadedTickets =
      ValueNotifier(null);

  @override
  ValueListenable<Iterable<TicketData>?> get tickets => _ticketController;
  @override
  ValueListenable<Iterable<TicketData>?> get unLoadedTickets =>
      _unLoadedTickets;

  _updateTickets() {
    _tickets.sort((a, b) => a.createAt.compareTo(b.createAt));

    _ticketController.value = _tickets.toList();

    _unLoadedTickets.value =
        _tickets.where((element) => element.localPath == null);
  }

  @override
  Future<void> getTickets() async {
    _tickets.clear();
    await _loadFromLocal();
    _updateTickets();
  }

  @override
  Future<void> createTicket(TicketData ticket) async {
    _tickets.sort((a, b) => a.createAt.compareTo(b.createAt));
    int? lastId;
    if (_tickets.isNotEmpty) {
      lastId = _tickets.last.id;
    }
    int index = (lastId ?? 0) + 1;
    _tickets.add(ticket.copyWith(id: index));
    await _saveLocal();
    getTickets();
  }

  @override
  Future<void> updateTicket(TicketData ticket) async {
    int index = _tickets.indexWhere((e) => e.id == ticket.id);
    if (index > -1) {
      _tickets.removeAt(index);
    }
    _tickets.add(ticket);
    await _saveLocal();
    getTickets();
  }

  @override
  Future<void> removeTicket(TicketData ticket) async {
    int index = _tickets.indexWhere((e) => e.id == ticket.id);
    if (index > -1) {
      _tickets.removeAt(index);
    }
    await _saveLocal();
    _removeFileIfExist(ticket.localPath);

    getTickets();
  }

  Future<void> _loadFromLocal() async {
    try {
      String resp = await _localStorage.read(key: "tickets");
      List json = jsonDecode(resp);
      for (var element in json) {
        _tickets.add(TicketData.fromJson(element));
      }
    } catch (_) {
      debugPrint("error");
    }
  }

  Future<void> _saveLocal() async {
    String json = jsonEncode(_tickets);
    await _localStorage.write(key: "tickets", value: json);
  }

  Future<void> _removeFileIfExist(String? path) async {
    if (path != null) {
      File(path).delete();
    }
  }
}
