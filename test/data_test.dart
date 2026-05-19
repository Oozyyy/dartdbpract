import 'package:test/test.dart';
import 'package:dartdbpract/dartdbpract.dart';

void main() {
  test('Client repository insert and get work correctly', () {
    final repo = ClientRepository();
    final client = Client(id: 'test1', fullName: 'Test', phone: '+79123456789', email: 'test@test.ru', address: 'Test');
    
    repo.insert(client);
    final clients = repo.getAll();
    
    expect(clients.any((c) => c.id == 'test1'), true);
    
    repo.delete('test1');
  });
}