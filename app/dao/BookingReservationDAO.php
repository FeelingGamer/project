<?php

class BookingReservationDAO
{
    protected function insert(Reservation $r, Pricing $p)
    {
        $sqlInsertBooking = 'INSERT INTO `booking` (`cid`, `status`, `notes`) VALUES (?, ?, ?)';
        $db = DB::getInstance();
        $stmt = $db->prepare($sqlInsertBooking);
        $stmt->execute(array($r->getCid(), $r->getStatus(), $r->getNotes()));
        $lastInsertedBookId = $db->lastInsertId();

        $sqlInsertReservation = 'INSERT INTO `reservation` (`id`, `start`, `end`, `package`, `requirement`, `host`, `popper`, `message`, `hash`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);';
        

        $exec = DB::getInstance()->prepare($sqlInsertReservation)->execute(
            array(
            $lastInsertedBookId,
            $r->getStart(),
            $r->getEnd(),
            $r->getPackage(),
            $r->getRequirement(),
            $r->getHost(),
            $r->getPopper(),
            $r->getMessage(),
            $r->getHash()
            )
        );

        // Pricing insertion of entries
        $pricingSql = 'INSERT INTO `pricing`(`booking_id`, `nights`, `total_price`, `booked_date`) VALUES (?, ?, ?, ?);';
        $pExec = DB::getInstance()->prepare($pricingSql)->execute([
            $lastInsertedBookId,
            $p->getNights(),
            $p->getTotalPrice(),
            $p->getBookedDate()
        ]);

        return $exec;
    }

    protected function update(Reservation $r)
    {
        $sql = 'UPDATE `reservation`';
        $sql .= ' SET `start`="' . $r->getStart() . '",';
        $sql .= '`end`="' . $r->getEnd() . '",';
        $sql .= '`package`="' . $r->getPackage() . '",';
        $sql .= '`requirement`="' . $r->getRequirement() . '",';
        $sql .= '`host`=' . $r->getHost() . ',';
        $sql .= '`popper`=' . $r->getPopper() . ',';
        $sql .= '`message`="' . $r->getMessage() . ',';
        $sql .= '`hash`="' . $r->getHash() . '"';
        $sql .= ' WHERE `id`=' . $r->getId();
        $stmt = DB::getInstance()->prepare($sql);
        $exec = $stmt->execute();
        return $exec;
    }

    protected function delete(Reservation $r)
    {
        $sql = 'DELETE FROM `booking` WHERE `booking`.`id` = ? AND `booking`.`cid` = ?';
        $stmt = DB::getInstance()->prepare($sql);
        $stmt->execute([$r->getId(), $r->getCid()]);
        $exec = $stmt->rowCount();
        return $exec;
    }
}
