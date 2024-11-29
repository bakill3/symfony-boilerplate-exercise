<?php

namespace App\Controller;

use App\Entity\Transaction;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class TransactionsController extends AbstractController {
    #[Route('/transactions', name: 'get_transactions', methods: ['GET'])]
    public function getTransactions(EntityManagerInterface $entityManager): JsonResponse {
        $user = $this->getUser();

        if (!$user) {
            return new JsonResponse(['error' => 'Unauthorized'], 401);
        }

        try {
            $transactions = $entityManager->getRepository(Transaction::class)->findBy(['user' => $user]);

            $data = array_map(function ($transaction) {
                return [
                    'id' => $transaction->getId(),
                    'amount' => $transaction->getAmount(),
                    'date' => $transaction->getDate() ? $transaction->getDate()->format('Y-m-d H:i:s') : null,
                    'location' => $transaction->getLocation() ?: null,
                    'payment_label' => $transaction->getPaymentLabel() ?: 'Unknown',
                    'gps_latitude' => $transaction->getGpsLatitude(),
                    'gps_longitude' => $transaction->getGpsLongitude(),
                ];
            }, $transactions);

            return new JsonResponse($data, 200);
        } catch (\Exception $e) {
            return new JsonResponse(['error' => 'An error occurred while fetching transactions', 'details' => $e->getMessage()], 500);
        }
    }

    #[Route('/transactions/{id}/location', name: 'update_transaction_location', methods: ['POST'])]
    public function updateTransactionLocation(
        int $id,
        Request $request,
        EntityManagerInterface $entityManager
    ): JsonResponse {
        try {
            $transaction = $entityManager->getRepository(Transaction::class)->find($id);

            if (!$transaction) {
                return new JsonResponse(['error' => 'Transaction not found'], 404);
            }

            $data = json_decode($request->getContent(), true);

            if (empty($data['location']) || !isset($data['gps_latitude']) || !isset($data['gps_longitude'])) {
                return new JsonResponse(['error' => 'Invalid location data'], 400);
            }

            $transaction->setLocation($data['location']);
            $transaction->setGpsLatitude($data['gps_latitude']);
            $transaction->setGpsLongitude($data['gps_longitude']);
            $entityManager->flush();

            return new JsonResponse(['message' => 'Location updated successfully'], 200);
        } catch (\Exception $e) {
            return new JsonResponse(['error' => 'Failed to update location', 'details' => $e->getMessage()], 500);
        }
    }
}
