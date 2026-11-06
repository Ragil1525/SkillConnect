const db = require('../config/db');

// 1. Pembayaran Jasa (Fitur 11)
exports.payOrder = (req, res) => {
    const { order_id } = req.params;
    const { payment_method } = req.body; // contoh: transfer_bank, qris, dll

    const query = `UPDATE orders SET payment_status = 'paid', status = 'processing' WHERE id = ?`;
    
    db.query(query, [order_id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });
        res.json({ message: 'Pembayaran berhasil dikonfirmasi, pesanan diteruskan ke penyedia jasa!' });
    });
};

// 2. Provider Menerima atau Menolak Pesanan (Fitur 12)
exports.respondOrder = (req, res) => {
    const { order_id } = req.params;
    const { action } = req.body; // 'accept' atau 'reject'

    let workStatus = action === 'accept' ? 'accepted' : 'rejected';
    let orderStatus = action === 'accept' ? 'accepted' : 'cancelled';

    const query = `UPDATE orders SET work_status = ?, status = ? WHERE id = ?`;

    db.query(query, [workStatus, orderStatus, order_id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });
        res.json({ message: `Pesanan berhasil ${action === 'accept' ? 'diterima' : 'ditolak'}!` });
    });
};

// 3. Pengelolaan Status Pekerjaan oleh Provider (Fitur 13)
exports.updateWorkStatus = (req, res) => {
    const { order_id } = req.params;
    const { work_status } = req.body; // misal: 'in_progress'

    const query = `UPDATE orders SET work_status = ? WHERE id = ?`;

    db.query(query, [work_status, order_id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });
        res.json({ message: `Status pekerjaan berhasil diperbarui menjadi: ${work_status}` });
    });
};

// 4. Pengiriman / Penyerahan Hasil Pekerjaan oleh Provider (Fitur 14)
exports.submitWorkResult = (req, res) => {
    const { order_id } = req.params;
    const { result_proof } = req.body; // URL file hasil pekerjaan / catatan

    if (!result_proof) {
        return res.status(400).json({ message: 'Bukti atau link hasil pekerjaan wajib disertakan!' });
    }

    const query = `UPDATE orders SET result_proof = ?, work_status = 'completed', status = 'completed' WHERE id = ?`;

    db.query(query, [result_proof, order_id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });
        res.json({ message: 'Hasil pekerjaan berhasil diserahkan kepada customer!' });
    });
};
// 5. Konfirmasi Penyelesaian Pekerjaan oleh Customer (Fitur 15)
exports.confirmCompletion = (req, res) => {
    const { order_id } = req.params;

    // Pastikan pesanan sedang dalam status 'completed' (hasil sudah diserahkan oleh provider)
    const checkQuery = `SELECT status, work_status FROM orders WHERE id = ?`;
    
    db.query(checkQuery, [order_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });

        const order = results[0];
        if (order.work_status !== 'completed') {
            return res.status(400).json({ 
                message: 'Pekerjaan belum diserahkan oleh penyedia jasa!' 
            });
        }

        // Update status pesanan menjadi selesai sepenuhnya ('finished')
        const updateQuery = `UPDATE orders SET status = 'finished' WHERE id = ?`;
        db.query(updateQuery, [order_id], (err2, result) => {
            if (err2) return res.status(500).json({ error: err2.message });
            
            res.json({ 
                message: 'Pekerjaan berhasil dikonfirmasi selesai! Dana siap dicairkan ke penyedia jasa.' 
            });
        });
    });
};