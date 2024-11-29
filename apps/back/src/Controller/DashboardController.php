<?php

namespace App\Controller;

use App\Entity\Transaction;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class DashboardController extends AbstractController {
    #[Route('/dashboard', name: 'get_dashboard_data', methods: ['GET'])]
    public function getDashboardData(EntityManagerInterface $entityManager): JsonResponse {
        $user = $this->getUser();

        if (!$user) {
            return new JsonResponse(['error' => 'Unauthorized'], 401);
        }

        $transactionRepo = $entityManager->getRepository(Transaction::class);
        $transactions = $transactionRepo->findBy(['user' => $user]);

        $score = 0;
        $unvalidatedLocations = 0;
        $paymentLabelCounts = [];
        $identificationsCount = 0;

        foreach ($transactions as $transaction) {
            if (empty($transaction->getLocation())) {
                $unvalidatedLocations++;
            }

            $identificationsCount++;

            if ($identificationsCount <= 10) {
                $score += 5;
            } elseif ($identificationsCount <= 30) {
                $score += 3;
            } else {
                $score += 1;
            }

            $paymentLabel = $transaction->getPaymentLabel();
            if ($paymentLabel) {
                if (!isset($paymentLabelCounts[$paymentLabel])) {
                    $paymentLabelCounts[$paymentLabel] = 0;
                }
                $paymentLabelCounts[$paymentLabel]++;
            }
        }

        foreach ($paymentLabelCounts as $label => $count) {
            if ($count === 1) {
                $score += 20;
            }
        }

        return new JsonResponse([
            'score' => $score,
            'unvalidatedLocations' => $unvalidatedLocations,
        ]);
    }
}
